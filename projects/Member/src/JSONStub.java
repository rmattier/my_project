
public class JSONStub {
    public static void main(String[] args) {
        Member member       = new Member();
        Address address     = new Address();

        member.setId("1");
        member.setFirstName("Rick");
        member.setLastName("Mattier El");
        member.setEmail("rick.mattier@ll.mit.edu");

        member.setStreet("53 Tiffany Drive");
        member.setCity("Randolph");
        member.setState("Massachusetts");
        member.setZipCode("02368");

        member.setImagePath("/images/cardinfo/Rick_Mattier.jpg");


        JSONHandler handler     = new JSONHandler();

        String result           = handler.createMember(member);

        System.out.println(result);

        System.out.println("--------------------------------------------------------------------");


    }
}