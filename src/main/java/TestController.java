import com.jdon.mvc.annotations.In;
import com.jdon.mvc.http.FormFile;
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

public class TestController {

    private static DB db = new DB();

    @In
    private RequestBody requestBody;

    @Path("/")
    public Represent index() {
        return new Html("index.jsp");
    }

    @Path("/users")
    public Represent users() {
        return Json.create(db.all());
    }

    @Path("/users")
    @Post
    public Represent add_users(String name, String email) throws JSONException {
        User user = new User();
        user.setId(db.all().size() + 1);
        user.setName(name);
        user.setEmail(email);
        db.add(user);
        return Json.create(new Result(true, "add success"));
    }

    @Path("/users/:id")
    @Put
    public Represent update_users(int id) throws JSONException {
        JSONObject jsonObject = new JSONObject(requestBody.getContent());
        User user = new User();
        user.setId(id);
        user.setName(jsonObject.getString("name"));
        user.setEmail(jsonObject.getString("email"));
        db.add(user);
        return Json.create(new Result(true, "update successful"));
    }

    @Path("/users/:id")
    @Delete
    public Represent delete_users(int id) {
        db.del(id);
        return Json.create(db.all());
    }

    @Path("/upload")
    @Post
    public Represent upload(FormFile formFile) {
        return Json.create(new Result(true, "upload successful"));
    }

}