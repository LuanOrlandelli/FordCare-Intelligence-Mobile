import React, { useEffect } from "react";
import {
  View,
  ActivityIndicator,
  StyleSheet,
  Text,
} from "react-native";
import { router } from "expo-router";
import { getToken } from "../storage/tokenStorage";

export default function LoadingScreen() {
  async function checkLogin() {
    const token = await getToken();

    if (token) {
      router.replace("/dashboard");
    } else {
      router.replace("/login");
    }
  }

  useEffect(() => {
    checkLogin();
  }, []);

  return (
    <View style={styles.container}>
      <ActivityIndicator size="large" color="#003478" />

      <Text style={styles.text}>
        Carregando FordCare Intelligence...
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#F4F7FB",
  },
  text: {
    marginTop: 16,
    color: "#003478",
    fontSize: 16,
    fontWeight: "600",
  },
});