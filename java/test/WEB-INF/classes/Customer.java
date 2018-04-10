public class Customer {
   private String id;
   private String firstName;
   private String lastName;
   private String email;

   public Customer() {}

   public void setId(String ids)		{ this.id		= ids;			}
   public void setFirstName(String fname)	{ this.firstName	= fname;		}
   public void setLastName(String lname)	{ this.lastName		= lname;		}
   public void setEmail(String mail)		{ this.email		= mail;			}

   public String getId()			{ return id;					}
   public String getFirstName()			{ return firstName;				}
   public String getLastName()			{ return lastName;				}
   public String getEmail()			{ return email;					}

}
