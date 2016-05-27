library(jsonlite)
library(dplyr)


get_filtered_df_from_json <- function(jsonfile)
{
  # Read Json data file
  mdata <- fromJSON(jsonfile)
  
  # Assign a data frame
  rdata <- mdata$name
  
  # Create a dataframe with required data
  ndata <- data.frame(Email = rdata$personalInfo$primaryWorkEmail$address ,
                      IsActive = rdata$isActive ,
                      Office = rdata$job$primaryOffice$name ,
                      Countryname = rdata$job$primaryOffice$locatedAt$inCity$inCountry$name ,
                      Countrycode = rdata$job$primaryOffice$locatedAt$inCity$inCountry$isoCode ,
                      Division = rdata$job$primaryDivision$name ,
                      Department = rdata$job$primaryDepartment$name ,
                      Product = rdata$job$primaryProductGroup$name ,
                      Team = rdata$job$primaryTeam$name)
  
  # replace ',' in the json response value with '#'
  ndata$Division <- sub(",", "#", ndata$Division)
  ndata$Team <- sub(",", "#", ndata$Team)
  
  # Remove rows with email as <NA>
  ndata <- ndata[!is.na(ndata$Email),]
  return(ndata)
}

# Read all 

get_employee_details <- function()
{
  return (unique(rbind (get_filtered_df_from_json('a.json'),
                 get_filtered_df_from_json('e.json'),
                 get_filtered_df_from_json('i.json'),
                 get_filtered_df_from_json('o.json'),
                 get_filtered_df_from_json('u.json'))))
}
