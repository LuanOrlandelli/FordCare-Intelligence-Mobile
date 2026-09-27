import { Stack } from "expo-router";

export default function RootLayout() {
  return (
    <Stack>
      <Stack.Screen
        name="index"
        options={{ headerShown: false }}
      />

      <Stack.Screen
        name="login"
        options={{ headerShown: false }}
      />

      <Stack.Screen
        name="dashboard"
        options={{ title: "FordCare Intelligence" }}
      />

      <Stack.Screen
        name="customers"
        options={{ title: "Clientes" }}
      />

      <Stack.Screen
        name="customer-detail"
        options={{ title: "Detalhe do Cliente" }}
      />

      <Stack.Screen
        name="leads"
        options={{ title: "Leads" }}
      />

      <Stack.Screen
        name="create-lead"
        options={{ title: "Novo Lead" }}
      />

      <Stack.Screen
        name="ai"
        options={{ title: "IA FordCare" }}
      />
    </Stack>
  );
}