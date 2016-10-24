module Tree exposing (..)

type alias Children = List Tree
type Tree = Tree { label: String, children: Children } | Empty

-- type Children = Children (List Tree) | Empty
-- type alias Tree = { label: Int, children: Children }


createNode : String -> Tree
createNode label =
  Tree { label = label, children = [] }

addChild : Tree -> Tree -> Tree
addChild tree child =
  case tree of
    Tree tree -> Tree { tree | children = child :: tree.children }
    Empty -> Empty

addChildren : Tree -> List Tree -> Tree
addChildren tree children =
  case tree of
    Tree tree -> Tree { tree | children = (List.append tree.children children) }
    Empty -> Empty

firstChild : List Tree -> Tree
firstChild children =
    case (List.head children) of
      Just c -> c
      Nothing -> Empty
