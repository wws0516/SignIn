package signin.action;

import signin.entity.Attendance;
import signin.entity.User;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsDateJsonBeanProcessor;
import net.sf.json.util.CycleDetectionStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import signin.service.AttendanceService;
import signin.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping(value = "/user")
public class UserAction extends BaseAction {
    User user1;

    @Resource
    private UserService userService;
    @Resource
    private AttendanceService attendanceService;

    @RequestMapping("/")
    public String index(Model model, HttpServletResponse response) {
        return "forward:/login.jsp";
    }

    //用户注册
    @RequestMapping(value = "/register")
    public String register(HttpServletRequest request, HttpSession session, User user, HttpServletResponse response) {

        if (userService.test(user) != null) {
            request.setAttribute("errMsg", "用户名重复！");
            return "forward:/register.jsp";
        } else {
            userService.register(user);
            response.setContentType("text/html;charset=utf-8");
            try {
                response.getWriter().write("<script>alert('注册成功！');</script>");
                response.getWriter().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "forward:/login.jsp";
        }
    }

    //用户登陆
    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request, HttpServletResponse response, HttpSession session, User user) {
        System.out.println("---signin.action.user:" + user);
        user1 = userService.login(user);
        try {
            if (user1 != null) {
                session.setAttribute("user", user1);
            } else {
                request.setAttribute("errMsg", "用户名或密码有错！");
                return "forward:/login.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Attendance attendance = new Attendance();
        attendance.setUserId(user1.getId());
        attendance.setSigntime(new java.sql.Date(new Date().getTime()));
        System.out.println(attendance.getSigntime());
        if (attendanceService.select(attendance).size() <= 0) {
            response.setContentType("text/html;charset=utf-8");
            try {
                response.getWriter().write("<script>alert('您今天未签到，请签到！');</script>");
                response.getWriter().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "forward:/WEB-INF/jsp/main.jsp";
        }
        return "forward:/WEB-INF/jsp/main.jsp";
    }

    @RequestMapping("/selectMyAttendance")
    /**查询我的考勤记录**/
    public String selectMyAttendance(HttpServletRequest request, HttpSession session, Model model, String signtime) {
        Attendance attendance = new Attendance();
        User user = (User) session.getAttribute("user");
        attendance.setUserId(user.getId());
        System.out.println(signtime);
        if (signtime == null) {
            attendance.setSigntime(new java.sql.Date(new Date().getTime()));
            model.addAttribute("signtimee", new java.sql.Date(new Date().getTime()));
        } else {
            attendance.setSigntime(java.sql.Date.valueOf(signtime));
            model.addAttribute("signtimee", signtime);
        }

        List<Attendance> list = attendanceService.selectMyAttendance(attendance);
        System.out.println(list);

        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
        jsonConfig.registerJsonBeanProcessor(java.sql.Date.class, new JsDateJsonBeanProcessor());

        JSONArray json = JSONArray.fromObject(list, jsonConfig);

        String data = json.toString();
        model.addAttribute("data", data);

        return "forward:/WEB-INF/jsp/user/myAttendance.jsp";
    }

}
