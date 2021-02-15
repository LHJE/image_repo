This simple [Image Repo](https://image-repo-lhje.herokuapp.com/) serves as an example image repository.  This was complete for a tech challenge, and represents the completion of a simple Ruby on Rails task.

As a side note: because this is being hosted on Heroku, any images uploaded will disappear after 24 hours, so they'll have to either be edited or deleted by the original uploader if there is to be a non-broken image on the main page.

## Readme Content
- [User Interface](#user-interface)
- [Local Setup](#local-setup)
- [Test Suite](#test-suite)
- [Database Schema](#database-schema)
- [Project Board](#project-board)
- [Future Iterations](#future-iterations)
- [Author](#author)
- [License](#license)

## User Interface
- [Deployed application](https://image-repo-lhje.herokuapp.com/)

## Local Setup
- Versions
  - Rails .2.4
  - Ruby 2.5.3
- Fork and clone the repository
- `cd` in your local repo version and run the following commands
  - To install gems:
    -  `bundle` (if this fails, try to `bundle update` and then retry)
  - To setup database:
    - `rails db:create`
    - `rails db:migrate`
    - `rails db:seed`
- Run your own development server:
  - `rails s`

## Test Suite
- Run with `bundle exec rspec`
- All tests should be passing
- 100.0% test coverage

## Database Schema
- ![our schema](/schema.png)
- Description of tables:
  - Users: all user accounts
  - Images: A user-uploaded image
  - Active Storage Attachments/Active Storage Blobs: For Active Storage functionality

## Project Board
- [GitHub project](https://github.com/LHJE/shopify_image_repo/projects/1)
- Next steps / epics for development:
  - Styling
  - User profile page
  - Implementing GraphQL
  
## Future Iterations
- Don't display images after their image has been deleted by Heroku's 24 hour limit

## Author
- Luke Hunter James-Erickson  |  [Github](https://github.com/LHJE)  |  [LinkedIn](https://www.linkedin.com/in/luke-hunter-james-erickson-b65682143/)

## License
Copyright 2021 Luke Hunter James-Erickson

Permission is hereby granted to any person obtaining a copy of this software and associated materials to make use of the software and associated materials according to the terms of the MIT License (see included file `LICENSE_MIT`) IF AND ONLY IF they have not read any portion of this file.

Any person who has read any portion of this file may not make any use of the software and associated materials for any purpose whatsoever. Any permissions previously granted to any person to use this software and associated materials terminate and are revoked with immediate effect upon their reading of any portion of this file.
