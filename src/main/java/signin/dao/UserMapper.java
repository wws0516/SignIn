package signin.dao;

import org.apache.ibatis.annotations.Mapper;
import signin.entity.User;

@Mapper
public interface UserMapper {
    //登陆
    public User login(User user);

    //注册
    public Integer register(User user);

    //检查用户名是否重复
    public User test(User user);

}