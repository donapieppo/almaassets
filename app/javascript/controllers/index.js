// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import { DmTest, TurboModalController } from "dm_unibo_common"
application.register("turbo-modal", TurboModalController)

import GoodController from "./good_controller"
application.register("good", GoodController)

