package signin.dao;

import org.apache.ibatis.annotations.Mapper;
import signin.entity.Leave;

import java.util.Map;

@Mapper
public interface LeaveMapper {

    public Integer saveLeaveAndAttendance(Map<String, Object> map);

    public Integer update(Leave leave);

    public Integer deleteList(Integer[] pks1);

}