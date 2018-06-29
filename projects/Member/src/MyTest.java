import java.io.IOException;
import org.json.simple.*;

import com.fasterxml.jackson.databind.ObjectMapper;

public class MyTest {
    public static void main(String[] args)
            throws IOException {
        Member member           = new Member();

        member.setId("1");x
        member.setFirstName("Rick");
        member.setLastName("Mattier El");
        member.setEmail("rick.mattier@ll.mit.edu");

        member.setStreet("53 Tiffany Drive");
        member.setCity("Randolph");
        member.setState("Massachusetts");
        member.setZipcode("02368");

        ObjectMapper mapper     = new ObjectMapper();

        String jsonstring       = mapper.writeValueAsString(member);

        //System.out.println(jsonstring);
        //Member member1          = new Member();

        // Member student          = mapper.readValue(jsonstring, Member.class);
        member                  = mapper.readValue(jsonstring, Member.class);
        jsonstring              = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(member);


        System.out.println(jsonstring);
    }
}