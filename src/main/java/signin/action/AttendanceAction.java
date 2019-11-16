package signin.action;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import signin.entity.Attendance;
import signin.entity.Leave;
import signin.entity.Page;
import signin.entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsDateJsonBeanProcessor;
import net.sf.json.util.CycleDetectionStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import signin.service.AttendanceService;
import signin.service.LeaveService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/attendance")
public class AttendanceAction {

    @Autowired
    ObjectMapper objectMapper;

    @Resource
    private AttendanceService attendanceService;

    @Resource
    private LeaveService leaveService;

    @RequestMapping("/selectMyLeave")
    @ResponseBody
    /**查询我的请假记录**/
    public Object selectMyLeave(HttpSession session, String signtime) {
        Page<Attendance> page = new Page<Attendance>();
        if (signtime == null) {
            page.setSigntime(new java.sql.Date(new Date().getTime()));
        }
        if (signtime != null) page.setSigntime(java.sql.Date.valueOf(signtime));
        if (page.getPage() == null && page.getRows() == null) {
            page.setPage(1);
            page.setRows(5);
        }
        Attendance attendance = new Attendance();
        User user = (User) session.getAttribute("user");
        page.setUserId(user.getId());
        Map<String, Object> map = attendanceService.selectMyLeave(page).getPageMap();
        map.put("signtime", new SimpleDateFormat("yyyy-MM-dd").format(page.getSigntime()));
        return map;
    }

    //查询所有人的考勤记录
    @RequestMapping("/selectPage")
    @ResponseBody //如果返回json格式，需要这个注解，这里用来测试环境
    public Object selectPage(String signtime) {
        System.out.println(signtime);
        Page<Attendance> page = new Page<Attendance>();
        if (signtime == null) {
            page.setSigntime(new java.sql.Date(new Date().getTime()));
        }
        if (signtime != null) page.setSigntime(java.sql.Date.valueOf(signtime));
        if (page.getPage() == null && page.getRows() == null) {
            page.setPage(1);
            page.setRows(5);
        }
        System.out.println("---dselectPage:" + page + "|" + page);
        return attendanceService.selectPage(page).getPageMap();
    }

    //查询某个人的考勤记录
    @RequestMapping("/selectOneUser")
    public String selectOneUser(String login, String signtime, Model model, HttpSession session) {
        System.out.println(login);
        if (signtime == null) {
            signtime = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            model.addAttribute("signtimee", signtime);
        } else {
            model.addAttribute("signtimee", signtime);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        if (login == null) {
            login = (String) session.getAttribute("OneUser");
            System.out.println(login);
            map.put("login", login);
        } else map.put("login", login);
        map.put("signtime", signtime);

        List<Attendance> list = attendanceService.selectOneUser(map);
        System.out.println(list);
        session.setAttribute("OneUser", login);
        try {
            objectMapper.writeValueAsString(list);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        jsonConfig.registerJsonBeanProcessor(java.sql.Date.class, new JsDateJsonBeanProcessor());
        JSONArray json = JSONArray.fromObject(list, jsonConfig);
        String data = json.toString();
        model.addAttribute("data", data);
        return "forward:/WEB-INF/jsp/admin/OneUserAttendance.jsp";
    }

    //插入记录
    @RequestMapping("/insertAttendance")
    public void insert(Attendance attendance, HttpSession session, HttpServletResponse response) {
        User user = (User) session.getAttribute("user");
        attendance.setUserId(user.getId());
        attendance.setSigntime(new java.sql.Date(new Date().getTime()));
        attendance.setAttend(0);
        if (attendanceService.select(attendance).size() == 0) {
            attendanceService.insert(attendance);
            response.setContentType("text/html;charset=utf-8");
            try {
                response.getWriter().write("<script>alert('签到成功！');</script>");
                response.getWriter().flush();

            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println(attendanceService.select(attendance));
            response.setContentType("text/html;charset=utf-8");
            try {
                response.getWriter().write("<script>alert('您今天已签到，请勿重复签到！');</script>");
                response.getWriter().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/update")
    @ResponseBody
    public Integer update(Leave leave, HttpSession session, String signtime, Integer id) {

        Attendance attendance = new Attendance();
        attendance.setId(id);
        attendance.setSigntime(java.sql.Date.valueOf(signtime));
        attendanceService.update(attendance);
        return leaveService.update(leave);
    }
}
