import com.jdon.mvc.annotations.In;
import com.jdon.mvc.http.RequestBody;
import com.jdon.mvc.represent.Html;
import com.jdon.mvc.represent.Json;
import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.rs.method.Delete;
import com.jdon.mvc.rs.method.Path;
import com.jdon.mvc.rs.method.Post;
import com.jdon.mvc.rs.method.Put;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class TestController {

    private static Map<Integer, User> map = new ConcurrentHashMap<Integer, User>();

    static {
        User user = new User();
        user.setId(1);
        user.setName("oojdon");
        user.setEmail("vsmysee@gmail.com");
        map.put(user.getId(), user);
    }

    @In
    private RequestBody requestBody;

    @Path("/")
    public Represent index() {
        return new Html("index.jsp");
    }

    @Path("/users")
    public Represent users() {
        return new Json(map.values());
    }

    @Path("/users")
    @Post
    public Represent add_users(String name, String email) throws JSONException {
        User user = new User();
        user.setId(user.hashCode());
        user.setName(name);
        user.setEmail(email);
        map.put(user.getId(), user);
        return new Json(new Result(true, "add success"));
    }

    @Path("/users/:id")
    @Put
    public Represent update_users(int id) throws JSONException {
        JSONObject jsonObject = new JSONObject(requestBody.getContent());
        User user = new User();
        user.setId(id);
        user.setName(jsonObject.getString("name"));
        user.setEmail(jsonObject.getString("email"));
        map.put(user.getId(), user);
        return new Json(new Result(true,"update successful"));
    }

    @Path("/users/:id")
    @Delete
    public Represent delete_users(int id) {
        map.remove(id);
        return new Json(map.values());
    }

}