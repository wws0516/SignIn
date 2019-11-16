package signin.test;

import signin.SignInApplication;
import signin.dao.UserMapper;
import signin.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest(classes = SignInApplication.class)
public class UserTest {
    @Autowired
    private UserMapper userMapper;

    @Test
    public void test(){
        User user = new User();
        user.setLogin("wws");
        user.setPassword("123");
        System.out.println(userMapper.login(user));
    }
}
