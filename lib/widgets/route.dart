import '/components/customer_profile.dart';
import '/components/mobile_shop.dart';
import '/components/shop.dart';
import '/components/single_product.dart';
import '/forms/check_out.dart';
import '/forms/register_page.dart';
import '/forms/reset_password.dart';
import '/forms/signin_page.dart';
import '/pages/about.dart';
import '/pages/contact.dart';
import '/pages/customer_direction.dart';
import '/pages/our_team.dart';
import '/pages/reshaping_basket.dart';
import '/pages/return_policy.dart';
import '/pages/shipping_process.dart';
import '/pages/terms.dart';
import '/pages/wholesale.dart';
import '/responsive/desktop_scaffold.dart';
import '/responsive/mobile_scaffold.dart';
import '/responsive/responsive_layout.dart';
import '/tables/checkout_table.dart';
import '/widgets/cart.dart';

class Routes{
  static String cart="cart";
  static String dashboard="dashboard";
  static String mainShop="mainShop";
  static String singleProduct="singleProduct";
  static String login="login";
  static String signup="signup";
  static String checkout="checkout";
  static String table="table";
  static String resetPassword="resetPassword";
  static String about="about";
  static String contactPage="contactPage";
  static String customerDirection="customerDirection";
  static String ourTeam="ourTeam";
  static String wholesale="wholesale";
  static String terms="terms";
  static String returns="returns";
  static String shipping="shipping";
  static String reshape="reshape";
  static String userProfile="userProfile";
}

final pages={
  Routes.cart:(context)=>const CartView(),
  Routes.singleProduct:(context)=>const SingleProduct(),
  Routes.login:(context)=>const SignInPage(),
  Routes.signup:(context)=>const RegisterPage(),
  Routes.checkout:(context)=>CheckoutForm(),
  Routes.table:(context)=>TableExample(),
  Routes.resetPassword:(context)=>const ResetPassword(),
  Routes.about:(context)=>const AboutPage(),
  Routes.contactPage:(context)=>const ContactPage(),
  Routes.customerDirection:(context)=>const CustomerDirection(),
  Routes.ourTeam:(context)=>const OurTeam(),
  Routes.wholesale:(context)=>const Wholesale(),
  Routes.terms:(context)=>const TermsAndConditions(),
  Routes.returns:(context)=>const ReturnPolicy(),
  Routes.shipping:(context)=>const ShippingProcess(),
  Routes.reshape:(context)=>const ReshapingBasket(),
  Routes.userProfile:(context)=> CustomerProfilePage(),
  Routes.mainShop:(context)=>const ResponsiveLayout(isMobile: ShopPage(), isTablet: ShopPage(), isDesktop: ShopPage(),),
  Routes.dashboard:(context)=>const ResponsiveLayout(isMobile: DesktopScaffold(), isTablet: DesktopScaffold(), isDesktop: DesktopScaffold(),
  ),
};