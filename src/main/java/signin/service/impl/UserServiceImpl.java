package signin.service.impl;

import signin.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import signin.dao.UserMapper;
import signin.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(User user) {
        return userMapper.login(user);
    }

    @Override
    public Integer register(User user) {
        return userMapper.register(user);
    }

    @Override
    public User test(User user) {
        return userMapper.test(user);
    }


}
