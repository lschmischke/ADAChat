with Gtkada.Builder; use Gtkada.Builder;


package Contact_Window_Callbacks is

   procedure Search_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Update_Status  (Object : access Gtkada_Builder_Record'Class);
   procedure Add_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Offline_Contact_Action  (Object : access Gtkada_Builder_Record'Class);
   procedure Online_Contact_Action  (Object : access Gtkada_Builder_Record'Class);

end Contact_Window_Callbacks;
