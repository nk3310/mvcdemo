import java.util.Collection;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * User: Asion
 * Date: 13-6-20
 * Time: 上午10:28
 */
public class DB {

    private Map<Integer, User> map = new ConcurrentHashMap<Integer, User>();

    private AtomicInteger number = new AtomicInteger(1);

    {
        User user = new User();
        user.setId(number.intValue());
        user.setName("oojdon");
        user.setEmail("vsmysee@gmail.com");
        map.put(user.getId(), user);
    }

    public void del(int id) {
        map.remove(id);
    }

    public void update(User user) {
        map.put(user.getId(), user);
    }

    public void add(User user) {
        user.setId(number.incrementAndGet());
        map.put(user.getId(), user);
    }

    public Collection all() {
        return map.values();
    }
}
