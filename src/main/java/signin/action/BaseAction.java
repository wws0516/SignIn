package signin.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

@Controller
@RequestMapping(value = "/base")
public class BaseAction {
    @Resource
    public ServletContext application;

    //方法参数folder通过@PathVariable指定其值可以从@RequestMapping的{folder}获取，同理file也一样
    @RequestMapping("/{folder1}/{folder2}/{file}")
    public String goURL(@PathVariable String folder1, @PathVariable String folder2, @PathVariable String file) {
        return "forward:/WEB-INF/" + folder1 + "/" + folder2 + "/" + file + ".jsp";
    }

}
