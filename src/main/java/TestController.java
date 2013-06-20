import com.jdon.mvc.annotations.In;
import com.jdon.mvc.annotations.Path;
import com.jdon.mvc.http.FormFile;
import com.jdon.mvc.http.RequestBody;
import com.jdon.mvc.represent.Html;
import com.jdon.mvc.represent.Json;
import com.jdon.mvc.represent.Represent;
import org.json.JSONException;
import org.json.JSONObject;

public class TestController {

    private static DB db = new DB();

    @In
    private RequestBody requestBody;

    @Path("/")
    public Represent index() {
        return new Html("index");
    }

    @Path("/users")
    public Represent get() {
        return Json.create(db.all());
    }

    @Path("post:/users")
    public Represent add(User user){
        db.add(user);
        return Json.create(new Result(true, "add success"));
    }

    @Path("put:/users/:id")
    public Represent update(int id) throws JSONException {
        JSONObject jsonObject = new JSONObject(requestBody.getContent());
        User user = new User();
        user.setId(id);
        user.setName(jsonObject.getString("name"));
        user.setEmail(jsonObject.getString("email"));
        db.update(user);
        return Json.create(new Result(true, "update successful"));
    }

    @Path("delete:/users/:id")
    public Represent delete(int id) {
        db.del(id);
        return Json.create(db.all());
    }

    @Path("post:/upload")
    public Represent upload(FormFile formFile) {
        return Json.create(new Result(true, "upload successful"));
    }

}