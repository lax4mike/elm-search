module Tree exposing (..)


type Tree
    = Tree { id : Int, label : String, children : List Tree }



-- type Children = Children (List Tree) | Empty
-- type alias Tree = { label: Int, children: Children }


idIs : Int -> Tree -> Bool
idIs id tree =
    case tree of
        Tree tree ->
            tree.id == id


getLabel : Tree -> String
getLabel tree =
    case tree of
        Tree tree ->
            tree.label


createNode : Int -> String -> List Tree -> Tree
createNode id label children =
    Tree { id = id, label = label, children = children }


addChild : Tree -> Tree -> Tree
addChild tree child =
    case tree of
        Tree tree ->
            Tree { tree | children = child :: tree.children }


addChildren : Tree -> List Tree -> Tree
addChildren tree children =
    case tree of
        Tree tree ->
            Tree { tree | children = (List.append tree.children children) }


{-|
ldfsLog : og out nodes depth-first
-}
dfsLog : Tree -> List String
dfsLog tree =
    case tree of
        Tree tree ->
            List.concat
                [ [ tree.label ]
                , List.concatMap dfsLog tree.children
                ]


{-|
dfsFind : Find a node that satifies the given predicate function
          using depth-first traversal
-}
dfsFind : Tree -> (Tree -> Bool) -> Maybe Tree
dfsFind tree predicate =
    let
        poo =
            case tree of
                Tree tree ->
                    (Debug.log "looking in: " tree.label)
    in
        if (predicate tree) then
            -- if this tree is it, return it
            Just tree
        else
            -- otherwise, look in all the children
            let
                checkChildren : List Tree -> Maybe Tree
                checkChildren children =
                    case children of
                        [] ->
                            Nothing

                        first :: rest ->
                            case (dfsFind first predicate) of
                                Just found ->
                                    Just found

                                Nothing ->
                                    checkChildren rest
            in
                case tree of
                    Tree tree ->
                        checkChildren tree.children


{-|
brsLog : log out nodes breadth-first
-}
bfsLog : Tree -> List String
bfsLog tree =
    case tree of
        Tree tree ->
            let
                -- record this tree's label and it's children
                visited =
                    (tree.label) :: List.map getLabel tree.children

                -- a function to determine if a label is already in the visited list
                isNotInVisited : String -> Bool
                isNotInVisited label =
                    not (List.member label visited)

                -- recurse for each child, and filter out visited nodes
                newNodes =
                    List.filter isNotInVisited (List.concatMap bfsLog tree.children)
            in
                List.append visited newNodes



-- {-|
-- bfsFind : Find the node with the given id using breadth-first traversal
-- -}
-- bfsFind : Tree Int -> Maybe Tree
-- bfsFind tree id =
--     case tree of
--         Tree tree ->
--             if tree.id == id then
--                 -- if this tree is it, return it
--                 Just (Tree tree)
--             else
--                 let
--                     poo =
--                         "what'"
--                 in
--                     Just (Tree tree)
