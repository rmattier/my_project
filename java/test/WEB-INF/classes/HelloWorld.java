import java.io.*;
import java.utils.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class HelloWorld {
  public void doGet(HttpServletRequest req, HttpServletResponse res)
    throws ServletException, IOException
  {
      res.setContentType("text/html");
      PrintWriter out 	= res.getWriter();

      out.println("<BR>HelloWorld!!</BR>");
  }
}
