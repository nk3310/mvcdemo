import com.jdon.mvc.annotations.ExceptionHandler;
import com.jdon.mvc.converter.BindingException;
import com.jdon.mvc.core.ActionException;
import com.jdon.mvc.core.ExceptionResolver;
import com.jdon.mvc.flow.MaxUploadSizeException;
import com.jdon.mvc.represent.Json;
import com.jdon.mvc.represent.Represent;
import com.jdon.mvc.rs.java.Handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * User: Asion
 * Date: 13-6-24
 * Time: 下午3:05
 */
@ExceptionHandler
public class MyExceptionHandler implements ExceptionResolver {

    @Override
    public Represent resolveActionException(HttpServletRequest request, HttpServletResponse response, Handler handler, ActionException ex) {
        return null;
    }

    @Override
    public Represent resolveBindingException(HttpServletRequest request, HttpServletResponse response, Handler handler, BindingException ex) {
        return null;
    }

    @Override
    public Represent resolveUploadException(HttpServletRequest request, HttpServletResponse response, Handler handler, MaxUploadSizeException ex) {
        return Json.create(new Result(false, "upload fail"));
    }
}
