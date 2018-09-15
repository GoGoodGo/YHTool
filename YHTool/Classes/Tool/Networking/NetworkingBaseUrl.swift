//
//  NetworkingBaseUrl.swift
//  E_User
//
//  Created by YH_O on 2017/5/24.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation

let BASE_URL = "http://shop.dktoo.com/lee/"
let IMG_URL = ""

/** 商品 */

// 商品分类
public let GoodsCategory_URL = BASE_URL + "apigoods/category"

// 商品列表
public let GoodsList_URL = BASE_URL + "apigoods/index"

// 商品详情
public let GoodsDetial_URL = BASE_URL + "apigoods/detail"

// 商品评论
public let GoodsComment_URL = BASE_URL + "apigoods/getcomment"

// 店铺详情
public let ShopDetial_URL = BASE_URL + "apiuser/shopdetail"

/** 促销活动 */

// 拍卖列表
public let GoodsAuction_URL = BASE_URL + "apiauction/index"

// 竞拍详情
public let AuctionDetial_URL = BASE_URL + "apiauction/detail"

// 团购列表
public let GoodsGroup_URL = BASE_URL + "apigroup/index"

// 团购详情
public let GroupDetial_URL = BASE_URL + "apigroup/detail"

// 秒杀列表
public let GoodsTimelimit_URL = BASE_URL + "apispike/index"

// 秒杀详情
public let TimelimitDetial_URL = BASE_URL + "apispike/detail"

// 竞拍出价
public let AuctionBid_URL = BASE_URL + "apiauction/bidders"

// 竞拍购买
public let AuctionBuy_URL = BASE_URL + "apiauction/buy"

// 团购购买
public let GroupBuy_URL = BASE_URL + "apigroup/buy"

// 秒杀购买
public let TimelimitBuy_URL = BASE_URL + "apispike/buy"


/** 我的 */

// 我的地址
public let Address_URL = BASE_URL + "apiuser/myaddress"

// 新增地址
public let AddAddress_URL = BASE_URL + "apiuser/add_address"

// 编辑地址
public let EditAddress_URL = BASE_URL + "apiuser/editress"

// 删除地址
public let DelAddress_URL = BASE_URL + "apiuser/deladdress"

// 是否默认
public let DefaultAddress_URL = BASE_URL + "apiuser/is_default"

// 收藏
public let AddCollect_URL = BASE_URL + "apiuser/addcollect"

// 取消收藏
public let CancelCollect_URL = BASE_URL + "apiuser/delcollect"

// 我的收藏
public let MyCollect_URL = BASE_URL + "apiuser/collection"

// 我的订单
public let MyOrder_URL = BASE_URL + "apiuser/myorder"

// 待评价
public let NotEvaluate_URL = BASE_URL + "apiuser/ordergoods"

// 评价
public let Evaluate_URL = BASE_URL + "apiuser/comment"

// 图片上传
public let UploadFile_URL = BASE_URL + "api/uploadfile"

// 取消订单
public let OrderCancel_URL = BASE_URL + "apiuser/cancel"

// 确认收货
public let OrderReceive_URL = BASE_URL + "apiuser/receive"

// 新增提现账户
public let AddAccount_URL = BASE_URL + "apiuser/addaccount"

// 我的账户
public let MyAccount_URL = BASE_URL + "apiuser/myaccount"

// 编辑账户
public let EditAccount_URL = BASE_URL + "apiuser/editaccount"

// 删除账户
public let DelAccount_URL = BASE_URL + "apiuser/delaccount"

// 首页
public let Home_URL = BASE_URL + "apiuser/index"


/** 购物车 */

// 加入购物车
public let AddCart_URL = BASE_URL + "apicart/add"

// 购物车
public let Cart_URL = BASE_URL + "apicart/index"

// 更新数量
public let CartQuantity_URL = BASE_URL + "apicart/update"

// 商品单选
public let CartCheck_URL = BASE_URL + "apicart/one_check"

// 商品全选
public let CartAllCheck_URL = BASE_URL + "apicart/all_check"

// 删除商品
public let CartDelete_URL = BASE_URL + "apicart/drop"

/** 订单 */

// 提交购物车
public let CartSubmit_URL = BASE_URL + "apiorder/index"

// 订单生成
public let OrderDone_URL = BASE_URL + "apiorder/done"

// 订单详情
public let OrderDetial_URL = BASE_URL + "apiorder/orders_detail"

// 立即购买
public let Buy_URL = BASE_URL + "apiorder/buy"

// 订单支付
public let OrderPay_URL = BASE_URL + "apipay/orderinfo"

/** 收益 */

// 我的钱包
public let Income_URL = BASE_URL + "apiuser/walpublic let"

// 申请提现
public let ApplyWithdraw_URL = BASE_URL + "apiuser/apptixian"

// 取消提现
public let CancelWithdraw_URL = BASE_URL + "apiuser/canceltixian"
























