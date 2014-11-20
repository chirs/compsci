import java.util.HashMap;

public class Memoizer {
    private static Functor functor;
    private static HashMap<Object, Object> cache = new HashMap<Object, Object>();

    public Memoizer(Functor f){
	functor = f;
    }

    public static Object call(Object x){
	if (cache.get(x) == null){
	    Object m = functor.fn(x);
	    cache.put(x, m);
	    return m;
	}
	else { return cache.get(x);}
    }
    
    public static void main(String argv[]){
    }
}