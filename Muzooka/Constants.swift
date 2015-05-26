//
//  Constants.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/4/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import Foundation
import UIKit

public struct Constants
{
	// Google Keys
	public static let GOOGLE_CLIENT_ID = "427353249733-gnfc38u3bsg5dqqe4h7ao8etp99pl9hr.apps.googleusercontent.com"
	public static let GOOGLE_SCOPES = "https://www.googleapis.com/auth/plus.login email profile"
	
	public static let URL_SCHEME_GOOGLE = "com.googleusercontent.apps"
	public static let URL_SCHEME_MUZOOKA = "muzooka"
	
	// URLS
	public static let API_URL = "https://api23.muzooka.com"
	
	// http codes
	public static let HTTP_CODE_SUCCESS = 200
	public static let HTTP_CODE_CREATE = 201
	public static let HTTP_GET = "GET"
	public static let HTTP_POST = "POST"
	public static let HTTP_PUT = "PUT"
	
	// stored auth token key
	public static let AUTH_TOKEN_KEY = "authTokenKey"
	public static let FIRST_TIME_USE_SHOWN_KEY = "firstTimeKey"
	
	// images
	public static let IMAGE_DEFAULT_ART = "default_artwork"
	public static let IMAGE_LOGO = "login_muzooka_logo"
	public static let IMAGE_FIRST_TIME_0 = "first_time_use_0"
	public static let IMAGE_BUTTON_CLOSE = "medium_close_icon"
	
	// cell identifiers
	public static let SONG_CELL_IDENTIFIER = "SongCellIdentifier"
	public static let MENU_CELL_IDENTIFIER = "MenuCellIdentifier"
	public static let PARTNER_CELL_IDENTIFIER = "PartnerCellIdentifier"
	public static let PRODUCER_CELL_IDENTIFIER = "ProducerCellIdentifier"
	public static let SETTINGS_CELL_IDENTIFIER = "SettingsCellIdentifier"
	public static let ARTIST_SONG_CELL_IDENTIFIER = "ArtistSongCellIdentifier"
	
	// controller identifiers
	public static let FIRST_TIME_VIEW_CONTROLLER = "FirstTimeViewController"
	public static let CHART_VIEW_CONTROLLER = "ChartViewController"
	public static let PARTNER_VIEW_CONTROLLER = "PartnerViewController"
	public static let INDUSTRY_VIEW_CONTROLLER = "IndustryViewController"
	public static let SEARCH_VIEW_CONTROLLER = "SearchViewController"
	public static let PLAYLIST_VIEW_CONTROLLER = "PlaylistViewController"
	public static let SETTINGS_VIEW_CONTROLLER = "SettingsViewController"
	public static let LOGIN_VIEW_CONTROLLER = "LoginViewController"
	public static let PROFILE_VIEW_CONTROLLER = "ProfileViewController"
	public static let ARTIST_VIEW_CONTROLLER = "ArtistViewController"
	public static let SONG_INFO_VIEW_CONTROLLER = "SongInfoViewController"
	public static let EDIT_PROFILE_VIEW_CONTROLLER = "EditProfileViewController"
	
	// layout
	public static let BUTTON_CORNER_RADIUS: CGFloat = 5.0
	public static let INDICATOR_HEIGHT: CGFloat = 4.0
	public static let LABEL_HEIGHT: CGFloat = 24.0
	public static let PADDING: CGFloat = 10.0
	public static let BUTTON_PADDING: CGFloat = 36.0
	public static let BUTTON_HEIGHT: CGFloat = 52.0
	public static let STEP_LABEL_WIDTH: CGFloat = 300.0
	public static let STEP_LABEL_HEIGHT: CGFloat = 142.0
	public static let LINE_SPACING: CGFloat = 10.0
	public static let SCROLL_PADDING: CGFloat = 60.0
	public static let AVATAR_LINE_WIDTH: CGFloat = 6.0
	public static let AVATAR_MAX_SIZE: CGFloat = 120.0
	
	// text
	public static let TITLE_DONE = "Done"
	public static let TITLE_LOGIN = "Login"
	public static let TITLE_CLOSE = "Close"
	public static let TITLE_REGISTER = "Sign up or log in"
	public static let TITLE_NO_THANKS = "No thanks, I'll do it later"
	
	// font
	public static let FONT_PROXIMA_NOVA_REGULAR = "ProximaNova-Regular"
	public static let FONT_PROXIMA_NOVA_SEMIBOLD = "ProximaNova-Semibold"
	public static let FONT_PROXIMA_NOVA_THIN = "ProximaNova-Thin"
	
	public static let FONT_SIZE_STEP: CGFloat = 28.0
	public static let FONT_SIZE_STEP_BUTTON: CGFloat = 16.0
	public static let FONT_SIZE_SEGMENT: CGFloat = 14.0
	public static let FONT_SIZE_AVATAR: CGFloat = 20.0
	
	// tags
	public static let TAG_DISMISS = 1
	public static let TAG_ACTION = 2
	
	public static let TOTAL_ANIMATING_IMAGES = 30
}