// java:jboss/datasources/PostDS

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.naming.*;

import javax.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class GetCustomer extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException
    {
        res.setContentType("text/html");
        PrintWriter out             = res.getWriter();

        // Context ctx             = new InitialContext();

        // Customer customer           = new Customer();
        ArrayList<Customer> cust    = new ArrayList<>();

        String query                = "SELECT id,firstname,lastname,email from Customer ";

        try {

            Context ctx             = new InitialContext();
            DataSource ds           = (DataSource)ctx.lookup("PostgresDS");
            Connection conn         = ds.getConnection();
            Statement stmt          = conn.createStatement();
            ResultSet rs            = stmt.executeQuery(query);

            while (rs.next()) {
                Customer customer           = new Customer();

                customer.setId(rs.getString("id"));
                customer.setFirstName(rs.getString("firstName"));
                customer.setLastName(rs.getString("lastName"));
                customer.setEmail(rs.getString("email"));

                //out.println("Name: " + customer.getFirstName() + " " + customer.getLastName());
                cust.add(customer);
            }
        }
        catch (SQLException sqle) {
            out.println("Error: " + sqle);
        }
        catch (NamingException ne) {
            out.println("Error: Naming Error: " + ne);
        }

        out.println("<table border=0>");
        out.println("<th>First Name</th><th>Last Name</th><th>Email Address</th>");
        for (Customer customers : cust) {
            //Customer temp = new Customer();

            //temp        = customers;

            out.println("<tr><td>" + customers.getFirstName() + "</td><td>" + customers.getLastName() + "</td><td>" + customers.getEmail() + "</td></tr>");


        }
        out.println("</table>");
    }
}
