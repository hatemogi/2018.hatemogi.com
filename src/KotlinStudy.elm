module KotlinStudy exposing (Article, Block, Model, Span, articlesView)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Json.Decode as D exposing (Decoder, Value, decodeString, field, string)
import Json.Encode as E
import String as S


type alias Model =
    { key : Nav.Key }


type Span
    = T String
    | E String
    | L String String
    | URL String
    | I String


type Block
    = S (List Span)
    | UL (List Span)
    | OL (List Span)
    | Kotlin String String
    | Java String String


type alias Section =
    { title : String
    , content : List Block
    }


type alias Article =
    { id : String
    , title : String
    , sections : List Section
    }


data : List Article
data =
    [ study00 ]


study00 : Article
study00 =
    Article "intro"
        "코틀린 소개"
        [ Section "코틀린이란 무엇인가?"
            [ UL
                [ T "자바 플랫폼에서 돌아가는 프로그래밍 언어"
                , T "간결하고 실용적"
                , T "자바와의 상호운용성을 중시"
                , T "성능도 자바와 같은 수준"
                ]
            ]
        , Section "코틀린 맛보기"
            [ Kotlin "첫 예제" """
              data class Person(val name: String,
                                val age: Int? = null)
              fun main(args: Array<String>) {
                  val people = listOf(Person("영희"),
                                      Person("철수", age = 29))
                  val oldest = people.maxBy { it.age ?: 0 }
                  println("나이가 가장 많은 사람: $oldest")
               }

               // 결과: 나이가 가장 많은 사람: Person(name=철수, age=29)
               """
            ]
        ]


articleView : Article -> Html msg
articleView article =
    Html.article []
        (h1 [] [ text article.title ]
            :: List.map sectionView article.sections
        )


sectionView : Section -> Html msg
sectionView section =
    Html.section []
        (h2 [] [ text section.title ]
            :: List.map blockView section.content
        )


blockView : Block -> Html msg
blockView block =
    let
        li : Span -> Html msg
        li =
            Html.li [] << List.singleton << spanView
    in
    case block of
        S spans ->
            div [] (List.map spanView spans)

        UL spans ->
            Html.ul [] (List.map li spans)

        OL spans ->
            Html.ol [] (List.map li spans)

        Kotlin title code ->
            Html.node "code-editor"
                [ Attr.property "editorValue" <| E.string <| codeIndent code
                , Attr.property "language" <| E.string "kotlin"
                , Attr.style "width" "600px"
                , Attr.style "height" "300px"
                , Attr.attribute "id" "kotlin-example"
                ]
                []

        Java title code ->
            Html.pre [] [ text code ]


codeIndent : String -> String
codeIndent code =
    let
        lines =
            S.lines code
        nonEmptyLines =
            List.filter (not << S.isEmpty << S.trim) lines
        leftSpace =
            \s -> (S.length s) - (S.length <| S.trimLeft s)
        minLeft =
            Maybe.withDefault 20 <| List.minimum <| List.map leftSpace nonEmptyLines
    in
    S.join "\n" <| List.map (S.dropLeft minLeft) lines


spanView : Span -> Html msg
spanView span =
    case span of
        T text ->
            Html.text text

        _ ->
            Html.span [] []


articlesView : Model -> Html msg
articlesView model =
    articleView study00
