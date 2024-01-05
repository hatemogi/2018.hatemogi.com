module Main exposing (main)

import Article
import Browser
import Browser.Navigation as Nav
import Certs
import Essay
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy)
import Intro
import KotlinStudy as Kt
import List as L exposing (filter, map, sortBy)
import Markdown
import Projects as P
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , route : Route
    , projectFilter : Maybe P.Category
    }


type Route
    = R소개
    | R프로젝트
    | R글
    | R수료증
    | R404


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url (urlToRoute url) Nothing, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | UpdateProjectFilter (Maybe P.Category)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, route = urlToRoute url }, Cmd.none )

        UpdateProjectFilter f ->
            ( { model | projectFilter = f }, Cmd.none )



-- VIEW


urlToRoute : Url.Url -> Route
urlToRoute url =
    let
        paths =
            url.path
                |> String.split "/"
                |> L.map Url.percentDecode
                |> L.map (Maybe.withDefault "")
                |> filter (String.isEmpty >> not)
    in
    case paths of
        [] ->
            R소개

        [ "index.html" ] ->
            R소개

        [ "소개" ] ->
            R소개

        [ "프로젝트" ] ->
            R프로젝트

        [ "글" ] ->
            R글

        [ "수료증" ] ->
            R수료증

        _ ->
            R404


routeToTitle : Route -> String
routeToTitle route =
    case route of
        R소개 ->
            "소개"

        R프로젝트 ->
            "프로젝트"

        R글 ->
            "글"

        R수료증 ->
            "수료증"

        R404 ->
            "404"


routeToUrl : Route -> String
routeToUrl route =
    "/" ++ routeToTitle route


view : Model -> Browser.Document Msg
view model =
    { title = "hatemogi.com - " ++ routeToTitle model.route
    , body =
        [ menuView model
        , mainView model
        , footerView model
        ]
    }


menuView : Model -> Html Msg
menuView model =
    let
        menu route icon =
            li [ classList [ ( "active", model.route == route ) ] ]
                [ a [ href (routeToUrl route) ]
                    [ span [ class "icon is-small" ]
                        [ i [ class "fas", class icon ] [] ]
                    , span [] [ text (" " ++ routeToTitle route) ]
                    ]
                ]
    in
    nav [ class "container-fluid" ]
        [ ul [] [ li [] [ img [ src "img/hatemogi.svg", width 128 ] [] ] ]
        , ul []
            [ menu R소개 "fa-user-circle"
            , menu R프로젝트 "fa-file-code"
            , menu R글 "fa-edit"
            , menu R수료증 "fa-certificate"
            ]
        ]


mainView : Model -> Html Msg
mainView model =
    main_ [ class "container" ]
        [ case model.route of
            R소개 ->
                profileView

            R프로젝트 ->
                projectsView model

            R글 ->
                articlesView model

            R수료증 ->
                certificatesView model

            R404 ->
                notFoundView
        ]


footerView : Model -> Html Msg
footerView model =
    footer [ class "container-fluid" ]
        [ small [] [ text "© hatemogi 2022" ]
        ]


notFoundView : Html Msg
notFoundView =
    text "404 찾을 수 없습니다"


profileView : Html Msg
profileView =
    div []
        [ div [ class "card-image" ] [ img [ src "img/profile.jpg", width 256, class "round-5px" ] [] ]
        , div [ class "card-content has-text-left" ]
            [ p [] [ text "안녕하세요. 백엔드 개발자 김대현입니다. 어려서 취미로 시작한 프로그래밍에 푹 빠져서, 결국 직업 프로그래머가 되었습니다." ]
            , p [] [ text "스칼라, 클로저, 하스켈 같은 함수형 프로그래밍 언어를 공부하는 게 재미있어서, 어떻게 하면 다른 프로그래머들에게도 전파할 수 있을까 고민하기도 합니다." ]
            , p [] [ text "제주도🏝에 거주하며 바닷가에서 한적하게 쉬며 커피☕️ 마시는 것을 좋아합니다." ]
            ]
        , footer [ class "card-footer" ]
            [ p [ class "card-footer-item" ]
                [ span []
                    [ a [ href "https://medium.com/happyprogrammer-in-jeju" ]
                        [ i [ class "fab fa-medium fa-lg" ] []
                        , text " 미디엄 보기"
                        ]
                    ]
                ]
            ]
        ]


introView : Html Msg
introView =
    let
        headingf : Intro.Section -> Html Msg
        headingf section =
            case section.url of
                Just url ->
                    a [ href url ] [ text section.title ]

                Nothing ->
                    text section.title

        sectionf : Intro.Section -> Html Msg
        sectionf section =
            article [ class "media" ]
                [ div [ class "media-content" ]
                    [ h2 []
                        (headingf section
                            :: (case section.timeline of
                                    Just timeline ->
                                        [ small [ class "timeline" ] [ text timeline ] ]

                                    Nothing ->
                                        []
                               )
                        )
                    , markdown section.description
                    ]
                ]
    in
    div []
        (article [ class "message" ]
            [ div [ class "message-body" ]
                [ text """백엔드 개발자로 일하고 있습니다.
                       오랜 기간 명령형 OOP로 개발하다가, 함수형 프로그래밍에 매료되어,
                       Clojure, Scala, Haskell 같은 함수형 프로그래밍 언어를 공부하고 있습니다."""
                ]
            ]
            :: L.map sectionf Intro.data
            ++ [ div [ class "media" ]
                    [ a [ class "button is-info", href "/프로젝트" ] [ text "프로젝트 보기" ] ]
               ]
        )


projectsView : Model -> Html Msg
projectsView model =
    let
        categoryColor : Maybe P.Category -> String
        categoryColor cat =
            case cat of
                Just P.Work ->
                    "is-warning"

                Just P.Hobby ->
                    "is-info"

                Just P.Talk ->
                    "is-success"

                Just P.Translation ->
                    "is-primary"

                Nothing ->
                    "is-link"

        keyedEntryf : P.Project -> ( String, Html Msg )
        keyedEntryf p =
            ( p.title, lazy entryf p )

        entryf : P.Project -> Html Msg
        entryf p =
            article [ class "media" ]
                [ div [ class "media-left" ]
                    [ div [ class "tags has-addons" ]
                        [ span [ class "tag" ] [ text (String.fromInt p.year) ]
                        , span [ class "tag", class (categoryColor (Just p.category)) ] [ text (P.categoryToString p.category) ]
                        ]
                    ]
                , div [ class "media-content" ]
                    [ Html.p []
                        [ div [ class "content" ]
                            [ strong []
                                [ case p.url of
                                    Nothing ->
                                        text p.title

                                    Just url ->
                                        a [ href url ] [ text p.title, span [ class "icon" ] [ i [ class "fas fa-link fa-sm" ] [] ] ]
                                ]
                            , markdown p.description
                            ]
                        , div [ class "tags" ] (L.map (\t -> span [ class "tag" ] [ text t ]) p.tags)
                        ]
                    ]
                ]

        button : Maybe P.Category -> Html Msg
        button maybeCategory =
            span
                [ class "button"
                , classList [ ( categoryColor maybeCategory, model.projectFilter == maybeCategory ) ]
                , onClick (UpdateProjectFilter maybeCategory)
                ]
                [ text (Maybe.withDefault "전체" <| Maybe.map P.categoryToString maybeCategory) ]
    in
    div []
        [ article [ class "message" ]
            [ div [ class "message-body" ]
                [ markdown
                    """아래 일일이 열거한 것은 대부분 사소한 프로젝트들이라 애써 설명드릴만한 내용은 없지만,
               저 스스로 어떤 일들을 해왔는지 참고해서 앞으로 할 일들을 고민해보려 합니다.
               만약 그럴듯한 프로젝트가 있다면, 훌륭한 동료들이 하는 일에 작은 역할로 참여했던 것이고,
               나머지 대부분 사소한 프로젝트는 제가 단독으로 진행한 것들일 겁니다."""
                ]
            ]
        , div [ class "buttons has-addons" ]
            [ button Nothing, button (Just P.Work), button (Just P.Hobby), button (Just P.Talk), button (Just P.Translation) ]
        , Keyed.node "div"
            []
            (P.data
                |> filter
                    (\p ->
                        case model.projectFilter of
                            Just f ->
                                p.category == f

                            Nothing ->
                                True
                    )
                |> sortBy (\p -> -p.year)
                |> L.map keyedEntryf
            )
        ]


articlesView : Model -> Html Msg
articlesView model =
    let
        articlef : Article.Article -> Html Msg
        articlef a =
            article [ class "media" ]
                [ div [ class "media-content" ]
                    [ Html.a [ href a.url ] [ strong [] [ text a.title ], span [ class "icon" ] [ i [ class "fas fa-link fa-sm" ] [] ] ]
                    , markdown a.summary
                    ]
                ]
    in
    div []
        [ article [ class "message" ]
            [ div [ class "message-body" ]
                [ markdown
                    """부족하나마 나름의 생각을 정리한 글들을 주로 [미디엄](https://medium.com/happyprogrammer-in-jeju)에 올리고 있습니다.
               아래에 그 중 반응이 좋았거나, 제가 더 알리고 싶다고 생각하는 글을 몇 편 골라두었습니다."""
                ]
            ]
        , div [] (L.map articlef Article.data)
        ]


kotlinStudyView : Model -> Html Msg
kotlinStudyView model =
    Kt.articlesView (Kt.Model model.key)


certificatesView : Model -> Html Msg
certificatesView model =
    div []
        (article [ class "message" ]
            [ div [ class "message-body" ]
                [ p []
                    [ text """모범생 친구들 집에 놀러가보면, 벽에 폼나는 상장들이 걸려 있었습니다.
                    하지만 뛰놀기만 좋아했던 제게는 그런 장식품이 없었지요. 그 부러웠던 마음을 이제라도 달래려,
                    그간 받은 수료증이라도 이렇게 온라인에 걸어두렵니다. """
                    ]
                ]
            ]
            :: L.map certificateView Certs.data
        )


certificateView : Certs.Certificate -> Html Msg
certificateView cert =
    div [ class "box" ]
        [ article [ class "media" ]
            [ div [ class "media-left is-hidden-mobile" ]
                [ figure [ class "image" ]
                    [ a [ href cert.url ]
                        [ img
                            [ src ("thumbnails/" ++ cert.image)
                            , attribute "srcset" ("thumbnails/" ++ cert.image ++ " 2x")
                            ]
                            []
                        ]
                    ]
                ]
            , div [ class "media-content" ]
                [ div [ class "content" ]
                    [ h3 [] [ a [ href cert.url ] [ text cert.title ] ]
                    , p [] [ text cert.descrition ]
                    ]
                , div [ class "tags" ]
                    (L.map (\t -> span [ class "tag is-info" ] [ text t ]) cert.tags)
                ]
            ]
        ]


markdown : String -> Html Msg
markdown content =
    Markdown.toHtml [] content



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
