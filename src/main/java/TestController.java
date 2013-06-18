import com.jdon.mvc.annotations.In;
import com.jdon.mvc.represent.Html;
import com.jdon.mvc.represent.Json;
import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.rs.method.Delete;
import com.jdon.mvc.rs.method.Path;
import com.jdon.mvc.rs.method.Post;
import com.jdon.mvc.rs.method.Put;
import org.apache.commons.io.IOUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class TestController {

    @In
    private HttpServletRequest request;

    private static List<User> list = new CopyOnWriteArrayList<User>();

    @Path("/")
    public Represent index() {
        return new Html("index.jsp");
    }

    @Path("/users")
    public Represent users() {
        User user = new User();
        user.setId(1);
        user.setName("oojdon");
        user.setEmail("vsmysee@gmail.com");
        list.add(user);
        return new Json(list);
    }

    @Path("/users")
    @Post
    public Represent add_users() {
        User user = new User();
        user.setId(user.hashCode());
        user.setName("addName");
        user.setEmail("addEmail");
        return new Json(user);
    }

    @Path("/users/:id")
    @Put
    public Represent update_users(int id) {
        return new Json(list);
    }

    @Path("/users/:id")
    @Delete
    public Represent delete_users(int id) {
        return new Json(list);
    }

}