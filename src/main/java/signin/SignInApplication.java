package signin;

import javafx.application.Application;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SpringBootApplication
@Controller
@MapperScan(annotationClass = Mapper.class, basePackages = {"signin/dao"})
public class SignInApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
        return application.sources(Application.class);
    }

    @RequestMapping("hello")//请求路径
    @ResponseBody//返回json数据
    public String hello() {
        return "hello world！ 你好世界！";
    }

    public static void main(String[] args) {
        SpringApplication.run(SignInApplication.class, args);
    }

}
