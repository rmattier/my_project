// import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.json.simple.*;
import org.json.simple.parser.JSONParser;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;

import java.sql.*;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executor;
import javax.sql.*;
import javax.naming.*;

public class JSONHandler {
    // This Handler is a bunch of convenience method to make it easier to create/dismanle Memeber objects.

    //The below method is used to take in a json object and return a Member pojo.
    public Member getMember(String member) {

        Member myMember         = new Member();

        JSONParser parser       = new JSONParser();

        try {
            Object object       = parser.parse(member);
            JSONObject obj      = (JSONObject) object;



            myMember.setFirstName((String) obj.get("FirstName"));
            myMember.setLastName((String) obj.get("LastName"));
            myMember.setEmail((String) obj.get("EmailAddress"));
            myMember.setStreet("53 Tiffany Drive");
            myMember.setCity("Randolph");
            myMember.setState("MA");
            myMember.setZipCode("20368");
            myMember.setImagePath("/pictures/images/Rick_Mattier-jpg");

        }
        catch (Exception e)
        {
            System.out.println("Error: " + e);
        }

        return(myMember);
    }

    public Member getMemberById(String id) {
        Member member   = new  Member();
        try {

            member = retrieveMember(id);
        }
        catch (NamingException ne) {
            System.out.println("Naming Error: " + ne);
        }
        return (member);
    }

    public String createMember(Member member) {
        ObjectMapper mapper         = new ObjectMapper();

        ObjectNode customer         = mapper.createObjectNode();

        /* Customer Info
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
        */

        ArrayNode address           = customer.putArray("Address");
        ObjectNode addressInfo      = new ObjectMapper().createObjectNode();
        addressInfo.put("Street", member.getStreet());
        addressInfo.put("city", member.getCity());
        addressInfo.put("state", member.getState());
        addressInfo.put("zipcode", member.getZipCode());

        address.add(addressInfo);
        String jsonString       = "";
        try {
            jsonString          = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(customer);
            System.out.println(jsonString);
        }
        catch (Exception e) {
            System.out.println("Errors " + e);
        }

        return (jsonString);
    }

    private Member retrieveMember(String id)
        throws NamingException {

        Member member       = new Member();

        String query        =   "select id,firstname,lastname,email,image_path," +
                                "street,city,state,zipcode FROM member WHERE id='" + id + "'";

        Context ctx         = new InitialContext();
        DataSource ds       = (DataSource)ctx.lookup("jdbc/PostDS");

        try {
            Connection con          = ds.getConnection();
            // PreparedStatement ps    = con.prepareStatement(query);
            Statement stmt          = con.createStatement();
            ResultSet rs            = stmt.executeQuery(query);

            while (rs.next()) {
                member.setId(id);
                member.setFirstName(rs.getString(2));
                member.setLastName(rs.getString(3));
                member.setEmail(rs.getString(4));
                member.setImagePath(rs.getString(5));
                member.setStreet(rs.getString(6));
                member.setCity(rs.getString(7));
                member.setState(rs.getString(8));
                member.setZipCode(rs.getString(9));

            }

        }
        catch (SQLException sqle) {
            System.out.println("Error: " + sqle);
        }

        return (member);
    }
}