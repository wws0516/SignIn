package signin.action;

import signin.entity.Attendance;
import signin.entity.Leave;
import signin.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import signin.service.AttendanceService;
import signin.service.LeaveService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@Controller
@RequestMapping("/leave")
public class LeaveAction {

    @Resource
    private LeaveService leaveService;

    @Resource
    private AttendanceService attendanceService;

    //插入记录
    @RequestMapping("/insertLeave")
    public void insert(String signtime, Leave leave, HttpSession session, HttpServletResponse response) {
        Attendance attendance = new Attendance();
        User user = (User) session.getAttribute("user");
        attendance.setUserId(user.getId());
        if (signtime != null)
            attendance.setSigntime(java.sql.Date.valueOf(signtime));
        else
            attendance.setSigntime(new java.sql.Date(new Date().getTime()));
        attendance.setAttend(1);
        leaveService.saveLeaveAndAttendance(attendance, leave);
        response.setContentType("text/html;charset=utf-8");
        try {
            response.getWriter().write("<script>alert('请假成功！');</script>");
            response.getWriter().flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/deleteLeave")
    @ResponseBody
    public Integer delete(Integer pks[], Integer pks1[]) {

        System.out.println("---signin.action.pks:" + pks);
        Integer i = 0, j = 0;
        try {
            i = leaveService.deleteList(pks1);
            j = attendanceService.updateList(pks);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return i;
    }
}