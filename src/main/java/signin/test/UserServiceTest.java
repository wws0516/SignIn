package signin.test;

import signin.SignInApplication;
import signin.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import signin.service.UserService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SignInApplication.class)
public class UserServiceTest {
    @Autowired
    private UserService userService;
    @Test
    public void test(){
        User user = new User();
        user.setLogin("wws");
        user.setPassword("123");
        System.out.println(userService.login(user));
    }

}
