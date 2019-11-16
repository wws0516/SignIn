package signin.service;

import signin.entity.User;

public interface UserService {

    public User login(User user);

    public Integer register(User user);

    public User test(User user);

}
