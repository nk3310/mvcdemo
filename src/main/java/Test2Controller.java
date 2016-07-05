import com.jdon.mvc.annotations.Path;
import com.jdon.mvc.http.FormFile;
import com.jdon.mvc.represent.Html;
import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.represent.Text;

public class Test2Controller {

	
    @Path("/test")
    public Represent test() {
        return new Html("test");
    }
    
	@Path("/test2")
	public Represent test2() {
		System.out.println("test");
		String show = "test";
		return new Text(show);
	}

	@Path("post:/testusers")
    public Represent add(User user) {
        
		
        
		String show = "user.name = " + user.getName() + " user.email = " + user.getEmail();
		
		       
		return new Text(show);
    }
    
	@Path("post:/testupload")
    public Represent upload(FormFile file) {
    	
		
		String show = "你上传文件名是：" + file.getOriginalFilename() + " 文件长度是：" + file.getFileSize();
		
		System.out.println(show);
		
		return new Text(show);
		
		
    }
}