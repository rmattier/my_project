import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

public class MyDBTest {
    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence
            .createEntityManagerFactory("Member");

    public static void main(String[] args) {

        String id           = "2";
        String firstname    = "Tori";
        String lastname     = "Mattier El";
        String email        = "rick.mattier@ll.mit.edu";

        create(id, firstname, lastname, email);
    }

    public static void create(String id,String fname, String lname, String email) {
        EntityManager manager = ENTITY_MANAGER_FACTORY.createEntityManager();
        EntityTransaction transaction = null;

        try {
            // Get a transaction
            transaction = manager.getTransaction();
            // Begin the transaction
            transaction.begin();

            // Create a new Member object
            Member mem = new Member();
            mem.setId(id);
            mem.setFirstName(fname);
            mem.setLastName(lname);
            mem.setEmail(email);

            // Save the Member object
            manager.persist(mem);

            // Commit the transaction
            transaction.commit();

        } catch (Exception ex) {
            // If there are any exceptions, roll back the changes
            if (transaction != null) {
                transaction.rollback();
            }
            // Print the Exception
            ex.printStackTrace();
        } finally {
            // Close the EntityManager
            manager.close();
        }
    }
}


// 148 Chestnut St, Needham, Ma. 8:00am