// libtest.java      GSN    03 Oct 08
// 

import java.util.LinkedList;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.ListIterator;

interface Functor { Object fn(Object x); }

interface Predicate { boolean pred(Object x); }

public class libtest {

    // ****** your code starts here ******


public static Integer sumlist(LinkedList<Integer> lst) {
    Integer sum = new Integer(0);
    for ( Integer item : lst ) sum = item + sum;
    return sum;
}

public static Integer sumarrlist(ArrayList<Integer> lst) {
    Integer sum = new Integer(0);
    for ( Integer item : lst ) sum = item + sum;
    return sum;
}

public static LinkedList<Object> subset (Predicate p,
                                          LinkedList<Object> lst) {
    LinkedList<Object> sub = new LinkedList<Object>();
    for ( Object item : lst) {
	if (p.pred(item)) sub.add(item);
    }
    return sub;
}

public static LinkedList<Object> dsubset (Predicate p,
                                           LinkedList<Object> lst) {
    for (Iterator<Object> it = lst.iterator(); it.hasNext();)
	if (p.pred(it.next()))
	    it.remove();
    return lst;
}

public static Object some (Predicate p, LinkedList<Object> lst) {
    for ( Object item : lst ){
	if (p.pred(item)) return item;
    }
    return null;
}

public static LinkedList<Object> mapcar (Functor f, LinkedList<Object> lst) {
    LinkedList<Object> mapped = new LinkedList<Object>();
    for ( Object item : lst)
	mapped.add(f.fn(item));
    return mapped;
}

public static LinkedList<Object> merge (LinkedList<Object> lsta,
                                        LinkedList<Object> lstb) {

    Object first;
    LinkedList<Object> merged = new LinkedList<Object>();
    if (lsta.size() == 0 & lstb.size() == 0) return merged;
    if (lsta.size() == 0) return lstb;
    if (lstb.size() == 0) return lsta;
    Object a = lsta.getFirst();
    Object b = lstb.getFirst();
    boolean t = a.hashCode() > b.hashCode();
    if (t){
	first = lstb.getFirst();
	lstb.removeFirst();
    }
    else {
	first = lsta.getFirst();
	lsta.removeFirst();
    }
    LinkedList<Object> ll = merge(lsta, lstb);
    ll.addFirst(first);
    return ll;
}

public static LinkedList<Object> sort (LinkedList<Object> lst) {
    int len = lst.size();
    if (len <= 1) return lst;
    LinkedList<Object> l1 = new LinkedList<Object>();
    LinkedList<Object> l2 = new LinkedList<Object>();
    int i = 0;
    for (Object item: lst){
	if (0 == i % 2) l1.addLast(item);
	else l2.addLast(item);
	i += 1;
    }
    return merge(sort(l1), sort(l2));
}

public static LinkedList<Object> intersection (LinkedList<Object> lsta,
                                               LinkedList<Object> lstb) {
    LinkedList<Object> intersected = new LinkedList<Object>();
    for (Object item : lsta)
	if (lstb.contains(item))
	    intersected.add(item);
    return intersected;
}

public static LinkedList<Object> reverse (LinkedList<Object> lst) {
    LinkedList<Object> reversed = new LinkedList<Object>();
    for (Object item : lst)
	reversed.push(item);
    return reversed;
}

    // ****** your code ends here ******

    public static void main(String args[]) {
        LinkedList<Integer> lst = new LinkedList<Integer>();
        lst.add(new Integer(3));
        lst.add(new Integer(17));
        lst.add(new Integer(2));
        lst.add(new Integer(5));
        System.out.println("lst = " + lst.toString());
        System.out.println("sum = " + sumlist(lst));
        ArrayList<Integer> lstb = new ArrayList<Integer>();
        lstb.add(new Integer(3));
        lstb.add(new Integer(17));
        lstb.add(new Integer(2));
        lstb.add(new Integer(5));
        System.out.println("lstb = " + lstb.toString());
        System.out.println("sum = " + sumarrlist(lstb));

        final Predicate myp = new Predicate()
            { public boolean pred (Object x)
                { return ( (Integer) x > 3); }};

        LinkedList<Object> lstc = new LinkedList<Object>();
        lstc.add(new Integer(3));
        lstc.add(new Integer(17));
        lstc.add(new Integer(2));
        lstc.add(new Integer(5));
        System.out.println("lstc = " + lstc.toString());
        System.out.println("subset = " + subset(myp, lstc).toString());

        System.out.println("lstc     = " + lstc.toString());
        System.out.println("dsubset  = " + dsubset(myp, lstc).toString());
        System.out.println("now lstc = " + lstc.toString());

        LinkedList<Object> lstd = new LinkedList<Object>();
        lstd.add(new Integer(3));
        lstd.add(new Integer(17));
        lstd.add(new Integer(2));
        lstd.add(new Integer(5));
        System.out.println("lstd = " + lstd.toString());
        System.out.println("some = " + some(myp, lstd).toString());

        final Functor myf = new Functor()
            { public Integer fn (Object x)
                { return new Integer( (Integer) x + 2); }};

        System.out.println("mapcar = " + mapcar(myf, lstd).toString());


        LinkedList<Object> lste = new LinkedList<Object>();
        lste.add(new Integer(1));
        lste.add(new Integer(3));
        lste.add(new Integer(5));
        lste.add(new Integer(6));
        lste.add(new Integer(9));
        System.out.println("lste = " + lste.toString());

        LinkedList<Object> lstf = new LinkedList<Object>();
        lstf.add(new Integer(2));
        lstf.add(new Integer(3));
        lstf.add(new Integer(6));
        lstf.add(new Integer(7));
        System.out.println("lstf = " + lstf.toString());
        System.out.println("merge = " + merge(lste, lstf).toString());

        LinkedList<Object> lstg = new LinkedList<Object>();
        lstg.add(new Integer(39));
        lstg.add(new Integer(84));
        lstg.add(new Integer(5));
        lstg.add(new Integer(59));
        lstg.add(new Integer(86));
        lstg.add(new Integer(17));
        System.out.println("lstg = " + lstg.toString());

        System.out.println("intersection(lstd, lstg) = " + intersection(lstd, lstg).toString());
	
        System.out.println("reverse lste = " + reverse(lste).toString());

        System.out.println("sort(lstg) = " + sort(lstg).toString());
	

   }
}
