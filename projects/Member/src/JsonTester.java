import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class JsonTester {
    public static void main(String[] args) {
        Member member               = new Member();
        ObjectMapper mapper         = new ObjectMapper();

        ObjectNode customer         = mapper.createObjectNode();

        // Customer Info
        member.setId("1");
        member.setFirstName("Rick");
        member.setLastName("Mattier El");
        member.setEmail("rick.mattier@ll.mit.edu");
        member.setStreet("53 Tiffany Drive");
        member.setCity("Randolph");
        member.setState("Massachusetts");
        member.setZipCode("02368");

        customer.put("memberId", member.getId());
        customer.put("firstname", member.getFirstName());
        customer.put("lastname", member.getLastName());
        customer.put("email", member.getEmail());

        ArrayNode address           = customer.putArray("Address");
        ObjectNode addressInfo      = new ObjectMapper().createObjectNode();
        addressInfo.put("Street", member.getStreet());
        addressInfo.put("city", member.getCity());
        addressInfo.put("state", member.getState());
        addressInfo.put("zipcode", member.getZipCode());

        address.add(addressInfo);

        try {
            System.out.println(mapper.writerWithDefaultPrettyPrinter().writeValueAsString(customer));
        }
        catch (Exception e) {
            System.out.println("Errors " + e);
        }

    }
}
