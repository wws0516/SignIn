package signin.service;

import signin.entity.Attendance;
import signin.entity.Leave;

public interface LeaveService {

    public void saveLeaveAndAttendance(Attendance attendance, Leave leave);

    public Integer update(Leave leave);

    public Integer deleteList(Integer[] pks1);

}
