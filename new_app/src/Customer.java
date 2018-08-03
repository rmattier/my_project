import java.io.*;

public class Customer {
  private int id;
  private String firstName;
  private String lastName;
  private String emailAddress;

  public Customer() {}

  public void setId(int id)                         { id                      = this.id;            }
  public void setFirstName(String firstname)        { firstName               = this.firstName;     }
  public void setLastName(String lastName)          { lastName                = this.lastName;      }
  public void setEmailAddress(String emailAddress)  { emailAddress            = this.emailAddress;  }

  public int getId()                                { return(id);                                   }
  public String getFirstName()                      { return(firstName);                            }
  public String getLastName()                       { return(lastName);                             }
  public String getEmailAddress()                   { return(emailAddress);                         }
}
