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
	
	// doesn't work
	//	public static let API_URL = "http://api-dev.muzooka.com"
	
	// prod url
	public static let API_URL = "https://api23.muzooka.com"
	
	// dev url
	//public static let API_URL = "http://api-qc.muzooka.com"
	
	public static let WEB_URL = "https://muzooka.com/"
	
	
	public static let SONG_URL = "https://d2mh4r1oygq2ap.cloudfront.net/bands/"
	
	// http codes
	public static let HTTP_CODE_SUCCESS = 200
	public static let HTTP_CODE_CREATE = 201
	public static let HTTP_CODE_NO_CONTENT = 204
	public static let HTTP_GET = "GET"
	public static let HTTP_POST = "POST"
	public static let HTTP_PUT = "PUT"
	public static let HTTP_DELETE = "DELETE"
	
	// keys
	public static let AUTH_TOKEN_KEY = "authTokenKey"
	public static let FIRST_TIME_USE_SHOWN_KEY = "firstTimeKey"
	public static let RECENT_SEARCHES_KEY = "recentSearchesKey"
	public static let KEY_PERSONAL_PLAYLISTS = "Personal Playlists"
	public static let KEY_SUBSCRIBED_PLAYLISTS = "Subscribed Playlists"
	public static let KEY_HOT_CHARTS = "Playing from hot charts"
	public static let KEY_QUEUE = "Queue"
	
	// images
	public static let IMAGE_DEFAULT_ART = "default_artwork"
	public static let IMAGE_LOGO = "login_muzooka_logo"
	public static let IMAGE_FIRST_TIME_0 = "first_time_use_0"
	public static let IMAGE_BUTTON_CLOSE = "medium_close_icon"
	public static let IMAGE_FACEBOOK_ICON = "login_button_facebook"
	public static let IMAGE_GOOGLE_ICON = "login_button_google"
	public static let IMAGE_EMAIL_ICON = "login_button_email"
	public static let IMAGE_NAV_HEADER = "nav_header"
	public static let IMAGE_DEFAULT_PLAYLIST = "default_playlist"
	
	// cell identifiers
	public static let SONG_CELL_IDENTIFIER = "SongCellIdentifier"
	public static let MENU_CELL_IDENTIFIER = "MenuCellIdentifier"
	public static let PARTNER_CELL_IDENTIFIER = "PartnerCellIdentifier"
	public static let PRODUCER_CELL_IDENTIFIER = "ProducerCellIdentifier"
	public static let SETTINGS_CELL_IDENTIFIER = "SettingsCellIdentifier"
	public static let ARTIST_SONG_CELL_IDENTIFIER = "ArtistSongCellIdentifier"
	public static let PLAYLIST_CELL_IDENTIFIER = "PlaylistCellIdentifier"
	public static let PLAYLIST_SONG_CELL_IDENTIFIER = "PlaylistSongCellIdentifier"
	public static let PROFILE_PLAYLIST_CELL_IDENTIFIER = "ProfilePlaylistCellIdentifier"
	public static let SEARCH_CELL_IDENTIFIER = "SearchCellIdentifier"
	public static let SEARCH_ITEM_CELL_IDENTIFIER = "SearchItemCellIdentifier"
	public static let SEARCH_SONG_CELL_IDENTIFIER = "SearchSongCellIdentifier"
	public static let SEARCH_BAND_CELL_IDENTIFIER = "SearchBandCellIdentifier"
	public static let SEARCH_USER_CELL_IDENTIFIER = "SearchUserCellIdentifier"
	public static let SEARCH_PLAYLIST_CELL_IDENTIFIER = "SearchPlaylistCellIdentifier"
	public static let SONG_PLAYLIST_CELL_IDENTIFIER = "SongPlaylistCellIdentifier"
	public static let TAG_CELL_IDENTIFIER = "TagCellIdentifier"
	public static let FILTER_HEADER_IDENTIFIER = "FilterHeaderIdentifier"
	
	// controller identifiers
	public static let FIRST_TIME_VIEW_CONTROLLER = "FirstTimeViewController"
	public static let CHART_VIEW_CONTROLLER = "ChartViewController"
	public static let PARTNER_VIEW_CONTROLLER = "PartnerViewController"
	public static let INDUSTRY_VIEW_CONTROLLER = "IndustryViewController"
	public static let SEARCH_VIEW_CONTROLLER = "SearchViewController"
	public static let PLAYLIST_VIEW_CONTROLLER = "PlaylistViewController"
	public static let PLAYLIST_DETAIL_VIEW_CONTROLLER = "PlaylistDetailViewController"
	public static let SETTINGS_VIEW_CONTROLLER = "SettingsViewController"
	public static let LOGIN_VIEW_CONTROLLER = "LoginViewController"
	public static let PROFILE_VIEW_CONTROLLER = "ProfileViewController"
	public static let ARTIST_VIEW_CONTROLLER = "ArtistViewController"
	public static let SONG_INFO_VIEW_CONTROLLER = "SongInfoViewController"
	public static let EDIT_PROFILE_VIEW_CONTROLLER = "EditProfileViewController"
	public static let SEARCH_DETAIL_VIEW_CONTROLLER	= "SearchDetailViewController"
	public static let EXTENDED_PLAYER_VIEW_CONTROLLER = "ExtendedPlayerViewController"
	public static let DISCOVER_VIEW_CONTROLLER = "DiscoverViewController"
	public static let FILTER_VIEW_CONTROLLER = "FilterViewController"
	
	
	// layout
	public static let BUTTON_CORNER_RADIUS: CGFloat = 5.0
	public static let INDICATOR_HEIGHT: CGFloat = 4.0
	public static let LABEL_HEIGHT: CGFloat = 24.0
	public static let SMALL_GAP: CGFloat = 2.0
	public static let PADDING: CGFloat = 10.0
	public static let TAG_VERTICAL_PADDING: CGFloat = 8.0
	public static let BUTTON_PADDING: CGFloat = 36.0
	public static let BUTTON_HEIGHT: CGFloat = 52.0
	public static let STEP_LABEL_WIDTH: CGFloat = 300.0
	public static let STEP_LABEL_HEIGHT: CGFloat = 142.0
	public static let LINE_SPACING: CGFloat = 10.0
	public static let SCROLL_PADDING: CGFloat = 60.0
	public static let AVATAR_LINE_WIDTH: CGFloat = 6.0
	public static let AVATAR_MAX_SIZE: CGFloat = 120.0
	public static let TABLE_HEADER_HEIGHT: CGFloat = 44.0
	public static let PLAYLIST_HEADER_HEIGHT: CGFloat = 60.0
	public static let SIDE_PADDING: CGFloat = 20.0
	public static let BAND_CELL_HEIGHT: CGFloat = 140.0
	public static let SEARCH_CELL_HEIGHT: CGFloat = 70.0
	public static let DISCOVER_STROKE: CGFloat = 5.0
	public static let ROTATION_MAX: CGFloat	= 1.0
	public static let ROTATION_STRENGTH: CGFloat = 320.0
	public static let ROTATION_ANGLE: Float = Float(M_PI) / 8
	public static let SCALE_STRENGTH: Float = 4.0
	public static let SCALE_MAX: Float = 0.93
	public static let ACTION_MARGIN: CGFloat = 120.0
	public static let EXIT_MARGIN: CGFloat = 500.0
	public static let DRAG_SIZE: CGFloat = 250.0
	public static let DRAG_Y: CGFloat = 84.0
	public static let FILTER_HEIGHT: CGFloat = 40.0
	public static let FILTER_HEADER_HEIGHT: CGFloat = 50.0
	public static let SEGMENT_HEIGHT: CGFloat = 44.0
	public static let SLIDER_TRACK_HEIGHT: CGFloat = 6.0
	public static let ALBUM_ART_SIZE: CGFloat = 240.0
	
	// text
	public static let TITLE_DONE = "Done"
	public static let TITLE_LOGIN = "Login"
	public static let TITLE_CLOSE = "Close"
	public static let TITLE_REGISTER = "Sign up or log in"
	public static let TITLE_NO_THANKS = "No thanks, I'll do it later"
	public static let TITLE_RECENTLY_SEARCHED = "Recently searched"
	public static let TITLE_CANCEL = "Cancel"
	
	
	// font
	public static let FONT_PROXIMA_NOVA_REGULAR = "ProximaNova-Regular"
	public static let FONT_PROXIMA_NOVA_SEMIBOLD = "ProximaNova-Semibold"
	public static let FONT_PROXIMA_NOVA_THIN = "ProximaNova-Thin"
	
	public static let FONT_SIZE_STEP: CGFloat = 28.0
	public static let FONT_SIZE_STEP_BUTTON: CGFloat = 16.0
	public static let FONT_SIZE_SEGMENT: CGFloat = 15.0
	public static let FONT_SIZE_AVATAR: CGFloat = 20.0
	public static let FONT_SIZE_TABLE_HEADER: CGFloat = 18.0
	public static let FONT_SIZE_SEARCH_HEADER: CGFloat = 13.0
	public static let FONT_SIZE_PLAYLIST_HEADER: CGFloat = 14.0
	public static let FONT_SIZE_TAG_TEXT: CGFloat = 15.0
	public static let FONT_SIZE_TAG_HEADER: CGFloat = 16.0
	
	// tags
	public static let TAG_DISMISS = 1
	public static let TAG_ACTION = 2
	
	public static let TOTAL_ANIMATING_IMAGES = 30
	
	public static let TOTAL_QUEUE_COUNT = 10
	
	public static let SHORT_ANIMATION_DURATION: NSTimeInterval = 0.25
	public static let MEDIUM_ANIMATION_DURATION: NSTimeInterval = 0.6
	
	public static let SCROLL_ALBUM_MAX_VISIBLE: Int = 3
}