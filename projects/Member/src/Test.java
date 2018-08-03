import org.json.simple.*;
import org.json.simple.parser.JSONParser;

public class Test {
    public static void main(String[] args) {
        JSONObject root         = new JSONObject();
        JSONArray main          = new JSONArray();

        root.put("Member", "Membership");

        JSONArray person        = new JSONArray();

        JSONObject member1      = new JSONObject();
        JSONObject address1     = new JSONObject();

        Member member           = new Member();
        Address address         = new Address();


        member.setFirstName("Rick");
        member.setLastName("Mattier El");
        member.setEmail("rick.mattier@ll.mit.edu");

        address.setStreet("53 Tiffany Drive");
        address.setCity("Randolph");
        address.setState("MA");
        address.setZipcode("02368");


        member1.put("FirstName",member.getFirstName());
        member1.put("LastName", member.getLastName());
        member1.put("Email", member.getEmail());

        address1.put("Street", address.getStreet());
        address1.put("City", address.getCity());
        address1.put("State", address.getState());
        address1.put("ZipCode", address.getZipcode());

        main.add(member1);
        main.add(address1);


        root.put("Address", address1);
        root.put("Member", member1);

        System.out.println(root.toJSONString());
        System.out.println(main.toJSONString());
    }
}