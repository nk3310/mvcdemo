import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.represent.Text;
import com.jdon.mvc.rs.method.Path;

public class TestController {

    @Path("/")
    public Represent index() {
        return new Text("hello");
    }

}