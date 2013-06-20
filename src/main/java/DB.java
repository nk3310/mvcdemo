import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * User: Asion
 * Date: 13-6-20
 * Time: 上午10:28
 */
public class DB {

    private Map<Integer, User> map = new ConcurrentHashMap<Integer, User>();

    {
        User user = new User();
        user.setId(1);
        user.setName("oojdon");
        user.setEmail("vsmysee@gmail.com");
        map.put(user.getId(), user);
    }

    public void del(int id) {
        map.remove(id);
    }

    public void add(User user) {
        map.put(user.getId(), user);
    }

    public Collection all() {
        return map.values();
    }
}
