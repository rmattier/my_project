import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "member")
public class Member {
    @Id
    @Column(name = "id", unique = true)
    private String id;

    @Column(name = "firstname", nullable = false)
    private String firstName;

    @Column(name = "lastname", nullable = false)
    private String lastName;

    @Column(name = "email", nullable = false)
    private String email;

    private String street;
    private String city;
    private String state;
    private String zipCode;
    private String imagePath        = "None";

    public Member() {}

    public Member(String fname, String lname, String mail) {
        this.firstName              = fname;
        this.lastName               = lname;
        this.email                  = mail;
    }

    // Mutators
    public void setId(String ids)               { this.id                               = ids;              }
    public void setFirstName(String fname)      { this.firstName                        = fname;            }
    public void setLastName(String lname)       { this.lastName                         = lname;            }
    public void setEmail(String mail)           { this.email                            = mail;             }
    public void setStreet(String st)            { this.street                           = st;               }
    public void setCity(String cty)             { this.city                             = cty;              }
    public void setState(String sta)            { this.state                            = sta;              }
    public void setZipCode(String zip)          { this.zipCode                          = zip;              }
    public void setImagePath(String image)      { this.imagePath                        = image;            }

    //Accessors
    public String getId()                       { return (id);                                              }
    public String getFirstName()                { return (firstName);                                       }
    public String getLastName()                 { return (lastName);                                        }
    public String getEmail()                    { return(email);                                            }
    public String getStreet()                   { return (street);                                          }
    public String getCity()                     { return (city);                                            }
    public String getState()                    { return (state);                                           }
    public String getZipCode()                  { return (zipCode);                                         }
    public String getImagePath()                { return (imagePath);                                       }


    /*
    @Override
    public String toString() {
        StringBuilder builder       = new StringBuilder();
        builder.append("Member [id=").append(id).append(", firstName=")
                .append(firstName).append(", lastName=").append(lastName).append(", emailAddress=")
                .append(email);

        return (builder.toString());

    } */
}