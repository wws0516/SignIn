package signin.service.impl;

import signin.dao.AttendanceMapper;
import signin.entity.Attendance;
import signin.entity.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import signin.service.AttendanceService;

import java.util.List;
import java.util.Map;

@Service("attendanceService")
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceMapper attendanceMapper;

    @Override
    public List<Attendance> select(Attendance attendance) {
        return attendanceMapper.select(attendance);
    }

    @Override
    public Page<Attendance> selectPage(Page<Attendance> page) {

        page.setList(attendanceMapper.selectPageList(page));
        page.setTotalRecords(attendanceMapper.selectPageCount(page));
        return page;
    }

    @Override
    public Integer insert(Attendance attendance) {

        return attendanceMapper.insert(attendance);
    }

    @Override
    public List<Attendance> selectMyAttendance(Attendance attendance) {
        return attendanceMapper.selectMyAttendance(attendance);
    }

    @Override
    public Page<Attendance> selectMyLeave(Page<Attendance> page) {
        page.setList(attendanceMapper.selectMyLeave(page));
        page.setTotalRecords(attendanceMapper.selectLeaveCount(page));
        return page;
    }

    @Override
    public Integer update(Attendance attendance) {
        return attendanceMapper.update(attendance);
    }

    @Override
    public Integer updateList(Integer[] pks) {
        return attendanceMapper.updateList(pks);

    }

    @Override
    public List<Attendance> selectOneUser(Map map) {
        return attendanceMapper.selectOneUser(map);
    }

}
