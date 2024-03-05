module Example.Errors where

import Effectful
import Example.Style as Style
import Web.Hyperbole


-- this is already running in a different context
page :: (Hyperbole :> es) => Page es Response
page = do
  hyper content

  load $ do
    pure $ row (pad 20) $ do
      col (gap 10 . border 1) $ do
        viewId Contents viewContent


data Contents = Contents
  deriving (Show, Read, Param)
instance HyperView Contents where
  type Action Contents = ContentsAction


data ContentsAction
  = CauseError
  deriving (Show, Read, Param)


content :: (Hyperbole :> es) => Contents -> ContentsAction -> Eff es (View Contents ())
content _ CauseError = do
  -- Return a not found error 404
  notFound


viewContent :: View Contents ()
viewContent = do
  col (gap 10 . pad 20) $ do
    button CauseError Style.btn "Not Found Error"