import com.jdon.mvc.represent.Html;
import com.jdon.mvc.represent.Json;
import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.rs.method.Path;
import com.jdon.mvc.rs.method.Post;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class TestController {

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
    public Represent add_users(String name,String email) {
        User user = new User();
        user.setId(user.hashCode());
        user.setName(name);
        user.setEmail(email);
        list.add(user);
        return new Json(list);
    }

}