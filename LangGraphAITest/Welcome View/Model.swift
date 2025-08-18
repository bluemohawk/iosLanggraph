//
//  Model_forAPI_or_ FireStore_Template.swift
//
//  Created by Francois Everhard Air on 6/1/25.
//


// Description
//This is an example of a Model for an API call template file.
// 1. it is a struct.
// 2. it conforms to Codable and allows the returned JSON to be decoded and coded easily by the APIService layer.
// 3. it is owned by a ViewModel instance through a var property (see ViewModel_Template file)

// Main Implementation Steps:
//  - provide variables matching the keys of interest in the api/JSON returned object


struct Model_forAPI_Template: Codable {
    
    //    @DocumentID var id: String?  <-- Add this to tell Firebase to create/map with a UUID (remember to Import FirebaseFirestore)
    let login: String
    let id: Int
    
}




