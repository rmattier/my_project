
public class Address {
    private String street;
    private String city;
    private String state;
    private String zipcode;

    public String getStreet()               { return (street);                      }
    public String getCity()                 { return (city);                        }
    public String getState()                { return (state);                       }
    public String getZipcode()              { return (zipcode);                     }

    public void setStreet(String st)        { this.street           = st;           }
    public void setCity(String cty)         { this.city             = cty;          }
    public void setState(String sta)        { this.state            = sta;          }
    public void setZipcode(String zip)      { this.zipcode          = zip;          }
}