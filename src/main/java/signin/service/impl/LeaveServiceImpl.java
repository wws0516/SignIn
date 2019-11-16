package signin.service.impl;

import signin.dao.AttendanceMapper;
import signin.dao.LeaveMapper;
import signin.entity.Attendance;
import signin.entity.Leave;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import signin.service.LeaveService;

import java.util.HashMap;
import java.util.Map;

@Service("leaveService")
public class LeaveServiceImpl implements LeaveService {

    @Autowired
    private AttendanceMapper attendanceMapper;

    @Autowired
    private LeaveMapper leaveMapper;

    @Override
    public void saveLeaveAndAttendance(Attendance attendance, Leave leave) {

        attendanceMapper.save(attendance);
        Map<String, Object> saveParams = new HashMap<String, Object>();
        saveParams.put("attendanceId", (Integer) attendance.getId());
        //这里指定两个角色的ID进行测试
        System.out.println(leave.getReason());
        saveParams.put("reason", (String) leave.getReason());
        leaveMapper.saveLeaveAndAttendance(saveParams);
    }

    @Override
    public Integer update(Leave leave) {
        return leaveMapper.update(leave);
    }

    @Override
    public Integer deleteList(Integer[] pks1) {
        return leaveMapper.deleteList(pks1);
    }


}
