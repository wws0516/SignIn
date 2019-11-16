package signin.dao;

import org.apache.ibatis.annotations.Mapper;
import signin.entity.Attendance;
import signin.entity.Page;

import java.util.List;
import java.util.Map;

@Mapper
public interface AttendanceMapper {

    public List<Attendance> select(Attendance attendance);

    //通过关键字分页查询，返回列表数据
    public List<Attendance> selectPageList(Page<Attendance> page);

    //通过关键字分页查询，返回总记录数
    public Integer selectPageCount(Page<Attendance> page);

    public Integer insert(Attendance attendance);

    public List<Attendance> selectMyAttendance(Attendance attendance);

    public Integer save(Attendance attendance);

    public List<Attendance> selectMyLeave(Page<Attendance> page);

    public Integer selectLeaveCount(Page<Attendance> page);

    //    更改请假时间
    public Integer update(Attendance attendance);

    //    更改请假变为签到
    public Integer updateList(Integer[] pks);

    public List<Attendance> selectOneUser(Map map);

}