using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BookStore.Model;

namespace BookStore.Helpers
{
    public enum UserRoleType
    {
        Guest = 0,
        Administrator = 1,
        Manager = 2,
        Client = 3
    }

    public static class SessionContext
    {
        public static User? CurrentUser { get; private set; }
        public static UserRoleType CurrentRole { get; private set; } = UserRoleType.Guest;

        public static string DisplayUserName =>
            CurrentUser != null ? CurrentUser.FullName : "Гость";

        public static string DisplayRoleName => CurrentRole switch
        {
            UserRoleType.Administrator => "Администратор",
            UserRoleType.Manager => "Менеджер",
            UserRoleType.Client => "Авторизированный клиент",
            _ => "Гость"
        };

        public static void LoginAsUser(User user)
        {
            CurrentUser = user;
            CurrentRole = user.RoleId switch
            {
                1 => UserRoleType.Administrator,
                2 => UserRoleType.Manager,
                3 => UserRoleType.Client,
                _ => UserRoleType.Guest
            };
        }

        public static void LoginAsGuest()
        {
            CurrentUser = null;
            CurrentRole = UserRoleType.Guest;
        }

        public static void Logout()
        {
            CurrentUser = null;
            CurrentRole = UserRoleType.Guest;
        }

        // Реальная проверка прав доступа согласно ролевой модели
        public static bool CanSearchSortFilterProducts =>
            CurrentRole == UserRoleType.Manager || CurrentRole == UserRoleType.Administrator;

        public static bool CanManageProducts =>
            CurrentRole == UserRoleType.Administrator;

        public static bool CanViewOrders =>
            CurrentRole == UserRoleType.Manager || CurrentRole == UserRoleType.Administrator;

        public static bool CanManageOrders =>
            CurrentRole == UserRoleType.Administrator;
    }
}
