package signin.service;

import signin.entity.Attendance;
import signin.entity.Page;

import java.util.List;
import java.util.Map;

public interface AttendanceService {

    public List<Attendance> select(Attendance attendance);

    //根据关键字分页查询
    public Page<Attendance> selectPage(Page<Attendance> page);

    public Integer insert(Attendance attendance);

    public List<Attendance> selectMyAttendance(Attendance attendance);

    public Page<Attendance> selectMyLeave(Page<Attendance> page);

    public Integer update(Attendance attendance);

    public Integer updateList(Integer pks[]);

    public List<Attendance> selectOneUser(Map map);

}
